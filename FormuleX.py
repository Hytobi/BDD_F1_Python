from os.path import exists
import sqlite3

DB_FILE_PATH = "base.db"
INIT_SCRIPT_FILE_PATH = "tables.sql"

def get_cursor():
    is_already_created = True
    if not exists(DB_FILE_PATH): is_already_created = False
    con = sqlite3.connect(DB_FILE_PATH)
    cur = con.cursor()
    if not is_already_created:
        init_database(cur)
    return cur

def init_database(cursor):
    print("Base de données créee !")
    init_script = open(INIT_SCRIPT_FILE_PATH)
    cursor.executescript(init_script.read())

def print_welcome():
    print()
    print("--- Bienvenue sur Formule X ---")
    print("La base de donnée numéro 1 en Formule 1 !")
    print()


def print_menu():
    print("1. Liste Pilotes")
    print("2. Détails Pilote")
    print("3. Liste Écuries")
    print("4. Détails Écurie")
    print("5. Liste Staff")
    print("6. Détails Staff")
    print("7. Liste Voitures")
    print("8. Détails Voitures")
    print("9. Classement Pilotes")
    print("0. Quitter\n")


def get_user_choice():
    return input("? ")


def handle_user_choice(choice, cursor):
    if choice == "1":
        print_driver_names(cursor)
    elif choice == "2":
        driver_name = input("Nom du pilote ? ")
        print_driver_details(driver_name, cursor)
    elif choice =="3":
        print_teams_names(cursor)
    elif choice =="4":
        team_name= input("Nom de l'écurie ? ")
        print_team_details(team_name, cursor)
    elif choice =="5":
        print_staff_names(cursor)
    elif choice =="6":
        staff_name = input("Nom du personnel ? ")
        print_staff_details(staff_name, cursor)
    elif choice=="7":
        print_car_names(cursor)
    elif choice =="8":
        car_name = input("Nom de la voiture ? ")
        print_car_details(car_name, cursor)
    elif choice == "9":
        print_class_pilotes(cursor)
    elif choice == "0":
        print("Au revoir, revenez bientôt !")
        exit()
    else:
        print("Choix invalide\n")

def print_driver_names(cursor):
    result = cursor.execute("SELECT nom_pilote FROM Pilote ORDER BY nom_pilote;")
    print()
    for row in result:
        driver_name = row[0]
        print(driver_name)
    print()

def print_driver_details(driver_name, cursor):
    result = cursor.execute(f"SELECT * FROM info_pilote WHERE nom_pilote LIKE '%{driver_name}%';")
    row = result.fetchone()
    print()
    if row is None:
        print(f"{driver_name} n'est pas un pilote")
        return
    print(f"Nom: {row[0]}")
    print(f"Age: {row[1]}")
    print(f"Numéro pilote: {row[2]}")
    print(f"Nom Écurie: {row[3]}")
    print(f"Classement général: {row[4]}")
    print(f"Nombre victoires: {row[5]}")
    print(f"Nombre pôle positions: {row[6]}")
    print()


def print_teams_names(cursor):
    result = cursor.execute("SELECT nom_ecurie FROM Ecurie ORDER BY nom_ecurie;")
    print()
    for row in result:
        team_name = row[0]
        print(team_name)
    print()



def print_team_details(team_name, cursor):
    result = cursor.execute(f"SELECT nom_ecurie, date_crea, class_constru FROM Ecurie WHERE nom_ecurie LIKE '%{team_name}%';")
    row= result.fetchone()
    print()
    if row is None:
        print(f"{team_name} n'est pas une écurie")
        return
    print(f"Nom: {row[0]}")
    print(f"Date de création: {row[1]}")
    print(f"Classement constructeur: {row[2]}")
    print()


def print_staff_names(cursor):
    result = cursor.execute("SELECT nom_staff FROM Staff ORDER BY nom_staff;")
    print()
    for row in result:
        staff_name=row[0]
        print(staff_name)
    print()


def print_staff_details(staff_name, cursor):
    result = cursor.execute(f"SELECT * FROM info_staff WHERE nom_staff LIKE '%{staff_name}%';")
    row = result.fetchone()
    print()
    if row is None:
        print(f"{staff_name} n'est pas un membre du staff ")
        return 
    print(f"Nom: {row[0]}")
    print(f"Âge: {row[1]}")
    print(f"Rôle: {row[2]}")
    print(f"Écurie: {row[3]}")
    print()


def print_car_names(cursor):
    result = cursor.execute("SELECT nom_voiture FROM info_voiture ORDER BY nom_voiture;")
    print()
    for row in result:
        car_name= row[0]
        print(car_name)
    print()


def print_car_details(car_name, cursor):
    result = cursor.execute(f"SELECT * FROM info_voiture WHERE nom_voiture LIKE '%{car_name}%';") 
    row=result.fetchone()
    print()
    if row is None:
        print(f"{car_name} n'est pas un véhicule ")  
        return
    print(f"Nom de la voiture : {row[0]}")
    print(f"Nom de l'écurie : {row[1]}")
    print(f"Nom du moteur: {row[2]}")
    print(f"Vitesse maximale : {row[3]}")
    print()


def print_class_pilotes(cursor):
    result = cursor.execute("SELECT * FROM classement_pilote ORDER BY classement_gen;")
    print()
    for row in result:
        a = row[0]
        b= row[1]
        c= row[2]
        print(f" {a}: {b} de chez {c}")
    print()




if __name__ == "__main__":
    cursor = get_cursor()
    print_welcome()
    choice = -1
    while (choice != 0):
        print_menu()
        choice = get_user_choice()
        handle_user_choice(choice, cursor)