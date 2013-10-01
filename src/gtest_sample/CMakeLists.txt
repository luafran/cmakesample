set (PRJ_NAME testOrder)

set (SOURCE_FILES
   testOrder.cpp
   Order.cpp
   Warehouse.cpp
)

add_executable(${PRJ_NAME} ${SOURCE_FILES} ${HEADER_FILES})

find_package(Threads)
target_link_libraries(${PRJ_NAME} gmock_main)

add_test(${PRJ_NAME} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${PRJ_NAME} --gtest_output=xml)

