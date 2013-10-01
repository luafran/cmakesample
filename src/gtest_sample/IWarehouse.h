#ifndef _IWAREHOUSE_H_
#define _IWAREHOUSE_H_

#include <string>

class IWarehouse
{
public:

   virtual ~IWarehouse() {}

   virtual void add(const std::string &item, int quantity) = 0;
   virtual void remove(const std::string &item, int quantity) = 0;
   virtual int getInventory(const std::string &item) = 0;
};

#endif

