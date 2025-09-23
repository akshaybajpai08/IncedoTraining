from sqlalchemy.orm import Session
from models import User
from typing import List, Optional
 
# Insert a new user in the database
 
def create_user(db:Session,name:str,email:str):
    db_user= User(name=name,email=email)    # Created a User object
    db.add(db_user)                         # Add it to the db
    db.commit()                             # Write it to DB
    db.refresh(db_user)                     # Get latest DB state
    return db_user                          # return the created object
 
# get all users
def get_all_users(db:Session)->List[User]:
    return db.query(User).all()
 
# get a user by id
def get_user(db:Session,user_id:int)->Optional[User]:
    return db.query(User).filter(User.id==user_id).first()
 
# update a user by id
def update_user(db:Session,user_id:int,name:Optional[str]=None,email:Optional[str]=None)->Optional[User]:
    user = get_user(db,user_id)
    if user:
        user.name=name
        user.email=email
        db.commit()
        db.refresh(user)
    return user
 
# delete a user by id
def delete_user(db:Session,user_id:int)->bool:
    user = get_user(db,user_id)
    if user:
        db.delete(user)
        db.commit()
    return True
 