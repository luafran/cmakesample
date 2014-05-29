#include "Warehouse.h"
#include <iostream>

Warehouse::Warehouse()
{
   std::cout << "Creating warehouse\n";
   m_items["Item1"] = 0;
   m_items["Item2"] = 0;
}

Warehouse::~Warehouse()
{
}

void Warehouse::add(const std::string &item, int quantity)
{
   m_items[item] += quantity; 
}

void Warehouse::remove(const std::string &item, int quantity)
{
   m_items[item] -= quantity; 
}

int Warehouse::getInventory(const std::string &item)
{
   return m_items[item]; 
}
