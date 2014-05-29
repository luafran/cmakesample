#include "gmock/gmock.h"

class MockWarehouse : public IWarehouse
{
public:
   MOCK_METHOD2(add, void(const std::string &item, int quantity)); 
   MOCK_METHOD2(remove, void(const std::string &item, int quantity));
   MOCK_METHOD1(getInventory, int(const std::string &item));
};
