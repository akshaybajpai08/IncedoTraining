from database import SessionLocal,engine,Base
 
from crud import create_user, get_all_users, get_user, update_user, delete_user
from models import User
 
def init_db():
    # Create the database table
    Base.metadata.create_all(bind=engine)


def display_menu():
    print("PRESS 1-6 TO PERFORM CRUD OPERATIONS")
    print("1: Create User")
    print("2: Read All Users")
    print("3: Read User by ID")
    print("4: Update User by ID")
    print("5: Delete User by ID")
    print("6: Exit")
    print("="*50)

db = SessionLocal()
def demo_crud():
    
    # create a new user
    user = create_user(db,name='John Doe',email='john12doe@example.com')
    print(f'Created User: {user.name} with email: {user.email}')

def create_user_menu():
    print("Enter user details!")
    n=input("Enter User name: ").strip()
    e= input("Enter User email: ").strip()
    
    print(f"Creating user with Name: {n}, Email : {e}")
    user = create_user(db,name=n,email=e)
    print(f'Created User: {user.name} with email: {user.email}')


def read_all_user():
    
    print("Reading all the users!!")
    all_user= get_all_users(db)
    print(f"All users are {all_user}")



def read_user_id():
    id=int(input("user id: "))
    getuserfromid= get_user(db,id)

    print(f"User with id :{id} is {getuserfromid}")


def update_user_id():
    name= input("Enter the name: ")
    email= input("Enter the email:")
    id = int (input(" updated user id: "))
    updateduserid=update_user(db,id,name,email)
    return updateduserid


def delete_user_id():
    id = int (input(" deleting user id: "))
    deletinguser=delete_user(db,id)
    return deletinguser


def exit_menu():
    pass


def main():
    print("Initializing the database....")
    print("Database initialized.")

    display_menu()
    inpt= int(input("Select the menu ").strip())

    if inpt==1:
        create_user_menu()
    elif inpt==2:
        read_all_user()
    elif inpt==3:
        read_user_id()
    elif inpt==4:
        update_user_id()
    elif inpt==5:
        delete_user_id()
    elif inpt==6:
        exit_menu()
    else:
        print("XXXXXXX  Selection number is incorrect XXXXXXXX")
        main()

    
    
 
if __name__=='__main__':
    # init_db()
    # demo_crud()
    main()