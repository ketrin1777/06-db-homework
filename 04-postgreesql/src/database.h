#pragma once

#include <iostream>
#include <string>
#include <pqxx/pqxx>

class DataBase
{
public:
    DataBase(const std::string &param);
    ~DataBase();

    void CreateDB(); // Создаем таблицы в базе

    // Добавить нового клиента
    void AddClient(const std::string &first_name, // Имя
                   const std::string &last_name,  // Фамилия
                   const std::string &email);     // E-mail

    // Добавить телефон для существующего клиента по ID
    void AddPhoneFromId(const int &id,             // ID
                        const std::string &phone); // Телефон

    // Удалить телефон
    void RemovePhone(const int &id);

    // Удалить телефон у клиента
    void RemovePhoneFromClient(const int &id,            // ID
                               const std::string &phone); // Телефон

    // Поиск клиентов
    std::vector<std::tuple<int, std::string, std::string, std::string>> FindClient(const std::string &first_name,               // Имя
                                                                                   const std::string &last_name,                // Фамилия
                                                                                   const std::string &email = std::string{""}); // E-mail

    // Поиск клиента по телефону
    pqxx::result FindClientFromPhone(const std::string &phone);

    // Удалить пользователя
    void RemoveUser(const int &id);

private:
    std::string param_;
};