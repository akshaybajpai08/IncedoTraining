import os 
#from dotenv import load_dotenv

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker,declarative_base



# we can also set these environment variables

DB_USER = os.getenv('DB_USER','')
DB_PASS = os.getenv('DB_PASS','')
DB_HOST = os.getenv('DB_HOST','localhost')
DB_NAME= os.getenv('DB_NAME','test_db')
DATABASE_URL = f"mysql+mysqlconnector://root:Incedo%401234@localhost/test_db"


engine=create_engine(DATABASE_URL, echo=True)


SessionLocal =sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base= declarative_base()
