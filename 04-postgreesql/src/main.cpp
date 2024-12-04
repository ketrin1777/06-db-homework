#include "database.h"
#include <Windows.h>
#pragma execution_character_set("utf-8")

int main()
{
    setlocale(LC_ALL, ".UTF-8");

    SetConsoleCP(CP_UTF8);
    SetConsoleOutputCP(CP_UTF8);
    setvbuf(stdout, nullptr, _IOFBF, 1000);

    DataBase *db = new DataBase("host=localhost "
                                "port=5432 "
                                "dbname=mydb "
                                "user=postgres "
                                "password=admin");
    try
    {
        db->CreateDB();

        db->AddClient("Alex", "Dans", "alex@mail.com");

        auto res_client = db->FindClient("Alex", "Dans");
        if (res_client.size() > 0)
        {
            db->AddPhoneFromId(std::get<0>(res_client[0]), "+7 859745454");
            db->AddPhoneFromId(std::get<0>(res_client[0]), "+7 859454554");
            for (const auto &item : res_client)
            {
                std::cout << std::get<1>(item) << std::endl;
            }

            // Удаляем телефон
            // db->RemovePhoneFromClient(std::get<0>(res_client[0]), "+7 859454554");

            // Удаляем Пользователя
            // db->RemoveUser(std::get<0>(res_client[0]));
        }

        // Поиск клиента по телефону
        pqxx::result res = db->FindClientFromPhone("+7 859454554");
        if (res.size() > 0) // Если найден
        {
            for (auto const &row : res)
            {
                for (auto const &field : row)
                    std::cout << field.c_str() << '\t';
                std::cout << std::endl;
            }
        }

        delete db;
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
    }
}