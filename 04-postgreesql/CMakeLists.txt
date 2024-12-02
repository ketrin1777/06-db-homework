cmake_minimum_required(VERSION 3.20.0)
project(cpppq)

set(CMAKE_CXX_STANDARD 17) 
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

set(PostgreSQL_ADDITIONAL_VERSIONS "15")
set(PostgreSQL_ROOT "c:/Program Files/PostgreSQL/15")
set(PostgreSQL_LIBRARIES "c:/Program Files/PostgreSQL/15/lib")
set(PostgreSQL_INCLUDE_DIRS "c:/Program Files/PostgreSQL/15/include")

# find_package(PostgreSQL REQUIRED)


file(GLOB proj
    src/*
)

add_executable(cpppq ${proj})

add_subdirectory(../libpq libpqxx-build) # Укажите путь к libpq++

target_compile_features(cpppq PRIVATE cxx_std_17) # Включите C++17
target_link_libraries(cpppq pqxx) # Слинкуйте libpq++ к проекту
