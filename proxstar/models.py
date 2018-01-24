from sqlalchemy import Column, Integer, String, Date
from sqlalchemy.ext.declarative import declarative_base

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
