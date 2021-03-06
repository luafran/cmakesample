#include "Order.h"
#include "Warehouse.h"
#include "MockWarehouse.h"
#include "gtest/gtest.h"
#include "gmock/gmock.h"
#include <string>

using ::testing::AtLeast;
using ::testing::Return;

namespace {

// The fixture for testing class Foo.
class OrderTest : public ::testing::Test
{
protected:
// You can remove any or all of the following functions if its body
// is empty.
    OrderTest() : ITEM_1("Item1"), ITEM_2("Item2")
    {
        // You can do set-up work for each test here.
    }

    virtual ~OrderTest()
    {
        // You can do clean-up work that doesn't throw exceptions here.
    }

    // If the constructor and destructor are not enough for setting up
    // and cleaning up each test, you can define the following methods:

    virtual void SetUp()
    {
        // Code here will be called immediately after the constructor (right
        // before each test).
        warehouse.add(ITEM_1, 50);
        warehouse.add(ITEM_2, 25);
    }

    virtual void TearDown()
    {
        // Code here will be called immediately after each test (right
        // before the destructor).
    }

    // Objects declared here can be used by all tests in the test case for Foo.
    const std::string ITEM_1;
    const std::string ITEM_2;
    Warehouse warehouse;
};

TEST_F(OrderTest, orderIsFilledIfEnoughInWarehouse)
{
   Order order(ITEM_1, 50);
   order.fill(warehouse);
   EXPECT_TRUE(order.isFilled());
   EXPECT_EQ(0, warehouse.getInventory(ITEM_1));
}

TEST_F(OrderTest, orderDoesNotRemoveIfNotEnough)
{
   Order order(ITEM_1, 51);
   order.fill(warehouse);
   EXPECT_FALSE(order.isFilled());
   EXPECT_EQ(50, warehouse.getInventory(ITEM_1));
}

TEST_F(OrderTest, orderIsFilledIfEnoughInWarehouseWithMock)
{
   MockWarehouse wmock;
   EXPECT_CALL(wmock, getInventory(ITEM_1)).Times(AtLeast(1)).WillOnce(Return(int(50)));
   EXPECT_CALL(wmock, remove(ITEM_1, 50)).Times(AtLeast(1));
   // Add With and After

   Order order(ITEM_1, 50);
   order.fill(wmock);
}

TEST_F(OrderTest, orderDoesNotRemoveIfNotEnoughWithMock)
{
   MockWarehouse wmock;
   EXPECT_CALL(wmock, getInventory(ITEM_1)).WillOnce(Return(int(50)));
   
   Order order(ITEM_1, 51);
   order.fill(wmock);
   EXPECT_FALSE(order.isFilled());
   EXPECT_EQ(50, warehouse.getInventory(ITEM_1));
}

} // namespace

#if 0
int main(int argc, char** argv)
{
  // The following line must be executed to initialize Google Mock
  //
  // (and Google Test) before running the tests.
  ::testing::InitGoogleMock(&argc, argv);
  return RUN_ALL_TESTS();
}
#endif

