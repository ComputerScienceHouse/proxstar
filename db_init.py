from sqlalchemy import Column, ForeignKey, Integer, String, Date
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from sqlalchemy import create_engine

Base = declarative_base()


class VM_Expiration(Base):
    __tablename__ = 'vm_expiration'
    id = Column(Integer, primary_key=True)
    expire_date = Column(Date, nullable=False)


engine = create_engine('sqlite:///proxstar.db')

Base.metadata.create_all(engine)
