#Project

```yaml
myproject
|--- database.py  # DB connection & base
|--- models.py    # SQLAlchemy model  
|-- crud.py       # CRUD function
|-- main.py       # main script 
|-- requirements.txt   # list of dependencies

```

###  Python Virtual Env

```bash

python -m venv venv
cd venv\Scripts
activate
```

### Write Dependencies

```
mysql-connector-pytho==8.0.33
SQLAlchemy==1.4.46
```

### Install Dependencies
```bash
pip install -r requirements.txt
```


### Run the app
```bash
python main.py
```
