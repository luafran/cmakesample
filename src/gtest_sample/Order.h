#ifndef _ORDER_H_
#define _ORDER_H_

#include <string>

class IWarehouse;

class Order
{
public:
   Order(const std::string& item, int quantity);
   ~Order();

   void fill(IWarehouse &warehouse);
   bool isFilled();

private:
   bool m_isFilled;
   std::string m_item;
   int m_quantity;
};

#endif

