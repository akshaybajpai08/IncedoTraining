from database import Base
from sqlalchemy import Column, Integer, String

class User(Base):
    __tablename__='users'

    id= Column(Integer, primary_key=True, index=True)
    name = Column(String(50), index=True, nullable=False)
    email= Column(String(100),unique=True,index=True,nullable=False)


    def __repo__(self):
        return f"User(id={self.id}, name={self.name},email={self.email})"