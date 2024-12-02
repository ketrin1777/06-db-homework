#include "database.h"

DataBase::DataBase(const std::string &param) : param_(param)
{
}

DataBase::~DataBase()
{
}

void DataBase::CreateDB()
{
    try
    {
        pqxx::connection c(param_.c_str());

        pqxx::work tx{c};

        std::string sql = "CREATE TABLE IF NOT EXISTS client ("
                          "id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,"
                          "first_name varchar NOT NULL,"
                          "last_name varchar NULL,"
                          "email varchar NULL,"
                          "CONSTRAINT client_pk PRIMARY KEY (id)"
                          ");";

        sql += "CREATE TABLE IF NOT EXISTS phone ("
               "id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,"
               "client_id int4 NOT NULL,"
               "phone varchar NOT NULL,"
               "CONSTRAINT phone_pk PRIMARY KEY (id),"
               "CONSTRAINT phone_fk FOREIGN KEY (client_id) REFERENCES client(id) ON DELETE CASCADE ON UPDATE CASCADE"
               ");";

        tx.exec(sql.c_str());
        tx.commit();
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
    }
}

void DataBase::AddClient(const std::string &first_name, const std::string &last_name, const std::string &email)
{
    try
    {
        pqxx::connection c(param_.c_str());

        pqxx::work tx{c};

        pqxx::result r = tx.exec("SELECT id FROM client WHERE first_name = '" + tx.esc(first_name.c_str()) + "' AND last_name = '" + tx.esc(last_name.c_str()) + "';");

        if (r.empty())
        {

            tx.exec("INSERT INTO client(first_name, last_name, email) "
                    "VALUES('" +
                    tx.esc(first_name.c_str()) + "', '" + tx.esc(last_name.c_str()) + "', '" + tx.esc(email.c_str()) + "')");
        }

        tx.commit();
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
    }
}

void DataBase::AddPhoneFromId(const int &id, const std::string &phone)
{
    try
    {
        pqxx::connection c(param_.c_str());

        pqxx::work tx{c};

        pqxx::result r = tx.exec("SELECT id FROM phone WHERE phone = '" + tx.esc(phone.c_str()) + "';");

        if (r.empty())
        {
            tx.exec("INSERT INTO phone(client_id, phone) "
                    "VALUES('" +
                    tx.esc(std::to_string(id).c_str()) + "', '" + tx.esc(phone.c_str()) + "')");

            tx.commit();
        }
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
    }
}

void DataBase::RemovePhone(const int &id)
{
    try
    {
        pqxx::connection c(param_.c_str());

        pqxx::work tx{c};

        tx.exec("DELETE FROM phone WHERE id = " + tx.esc(std::to_string(id)) + ";");

        tx.commit();
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
    }
}

void DataBase::RemovePhoneFromClient(const int &id, const std::string &phone)
{
    try
    {
        pqxx::connection c(param_.c_str());

        pqxx::work tx{c};

        tx.exec("DELETE FROM phone "
                "WHERE phone ='" +
                tx.esc(phone) + "' AND client_id = " + tx.esc(std::to_string(id)) + ";");

        tx.commit();
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
    }
}

std::vector<std::tuple<int, std::string, std::string, std::string>> DataBase::FindClient(const std::string &first_name, const std::string &last_name, const std::string &email)
{
    std::vector<std::tuple<int, std::string, std::string, std::string>> res;
    try
    {
        pqxx::connection c(param_.c_str());

        pqxx::work tx{c};

        std::string query = "SELECT * FROM client WHERE first_name = '" + tx.esc(first_name.c_str()) + "'";
        if (last_name.size() > 0)
        {
            query += " OR last_name = '" + tx.esc(last_name.c_str()) + "'";
        }

        if (email.size() > 0)
        {
            query += " OR email = '" + tx.esc(email.c_str()) + "'";
        }

        query += ";";

        auto reult = tx.query<int, std::string, std::string, std::string>(query);

        for (auto [id, first_name, last_name, email] : reult)
        {
            res.push_back({id, first_name, last_name, email});
        }
        return res;
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
    }
    return res;
}

pqxx::result DataBase::FindClientFromPhone(const std::string &phone)
{
    try
    {
        pqxx::connection c(param_.c_str());

        pqxx::work tx{c};

        pqxx::result r = tx.exec("SELECT * FROM client "
                                 "join phone "
                                 "on client.id  = phone.client_id WHERE phone.phone = '" +
                                 tx.esc(phone.c_str()) + "';");

        return r;
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
    }

    return pqxx::result{};
}

void DataBase::RemoveUser(const int &id)
{
    try
    {
        pqxx::connection c(param_.c_str());

        pqxx::work tx{c};

        tx.exec("DELETE FROM phone WHERE client_id = " + tx.esc(std::to_string(id)) + ";\nDELETE FROM client WHERE id = " +
                tx.esc(std::to_string(id)) + ";");

        tx.commit();
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << '\n';
    }
}
