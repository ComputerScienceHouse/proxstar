from sqlalchemy import Column, Integer, String, Date
from sqlalchemy.types import JSON, Text
from sqlalchemy.dialects import postgresql
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


class Pool_Cache(Base):
    __tablename__ = 'pool_cache'
    pool = Column(String(32), primary_key=True)
    vms = Column(postgresql.ARRAY(Text, dimensions=2), nullable=False)
    num_vms = Column(Integer, nullable=False)
    usage = Column(JSON, nullable=False)
    limits = Column(JSON, nullable=False)
    percents = Column(JSON, nullable=False)
