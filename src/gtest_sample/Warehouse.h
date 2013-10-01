#ifndef _WAREHOUSE_H_
#define _WAREHOUSE_H_

#include "IWarehouse.h"
#include <string>
#include <map>

class Warehouse : public IWarehouse
{
public:
   Warehouse();
   ~Warehouse();

   void add(const std::string &item, int quantity);
   void remove(const std::string &item, int quantity);
   int getInventory(const std::string &item);

private:
   std::map<std::string, int> m_items;
};

#endif

