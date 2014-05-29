#include "Order.h"
#include "Warehouse.h"

Order::Order(const std::string& item, int quantity) : m_isFilled(false), m_item(item), m_quantity(quantity)
{
}

Order::~Order()
{
}

void Order::fill(IWarehouse &warehouse)
{
   m_isFilled = false;
   int stock = warehouse.getInventory(m_item);
   if (stock >= m_quantity)
   {
      warehouse.remove(m_item, m_quantity);
      m_isFilled = true;
   }
}

bool Order::isFilled()
{
   return m_isFilled;
}

