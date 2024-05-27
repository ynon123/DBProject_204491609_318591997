import random
import cx_Oracle

username = 'SYSTEM'
password = '1234'
dsn = 'localhost/xe'
mode = cx_Oracle.SYSDBA

connection = cx_Oracle.connect(username, password, dsn, mode=mode)
print("Successfully connected to Oracle Database")
cursor = connection.cursor()

#
# def insert_values(ids):
#     for id in ids:
#         try:
#             cursor.execute('''
#             INSERT INTO LIVE_IN (ID)
#             VALUES (:1)
#             ''', (id,))
#             print(f'Inserted {id} into LIVE_IN')
#         except Exception as e:
#             print(e)
#     connection.commit()
#
# try:
#     ids_to_insert = [random.randint(1, 1000) for i in range(1, 1020)]
#     insert_values(ids_to_insert)
# except Exception as e:
#     print(e)
# cursor.close()
# connection.close()


def write_inserts_to_file(ids, filename):
    with open(filename, 'w') as file:
        for id in ids:
            try:
                insert_command = f"INSERT INTO LIVE_IN (ID) VALUES ({id});\n"
                file.write(insert_command)
                print(f'Wrote insert command for {id} to {filename}')
            except Exception as e:
                print(e)

try:
    ids_to_insert = [random.randint(1, 1000) for i in range(1, 1020)]
    write_inserts_to_file(ids_to_insert, 'live_in_insert.sql')
except Exception as e:
    print(e)
