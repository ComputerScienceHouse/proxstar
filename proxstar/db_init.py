from sqlalchemy import Column, ForeignKey, Integer, String, Date
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from sqlalchemy import create_engine

Base = declarative_base()


class VM_Expiration(Base):
    __tablename__ = 'vm_expiration'
    id = Column(Integer, primary_key=True)
    expire_date = Column(Date, nullable=False)


class Usage_Limit(Base):
    __tablename__ = 'usage_limit'
    id = Column(String(32), primary_key=True)
    cpu = Column(Integer, nullable=False)
    mem = Column(Integer, nullable=False)
    disk = Column(Integer, nullable=False)


engine = create_engine('sqlite:///proxstar.db')

Base.metadata.create_all(engine)
