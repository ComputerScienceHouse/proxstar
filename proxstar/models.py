from sqlalchemy import Column, Date, Integer, String
from sqlalchemy.dialects import postgresql
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.types import JSON, Text

from proxstar.util import default_repr

Base = declarative_base()


@default_repr
class VM_Expiration(Base):
    __tablename__ = 'vm_expiration'
    id = Column(Integer, primary_key=True)
    expire_date = Column(Date, nullable=False)


@default_repr
class Usage_Limit(Base):
    __tablename__ = 'usage_limit'
    id = Column(String(32), primary_key=True)
    cpu = Column(Integer, nullable=False)
    mem = Column(Integer, nullable=False)
    disk = Column(Integer, nullable=False)


@default_repr
class Pool_Cache(Base):
    __tablename__ = 'pool_cache'
    pool = Column(String(32), primary_key=True)
    vms = Column(postgresql.ARRAY(Text, dimensions=2), nullable=False)
    num_vms = Column(Integer, nullable=False)
    usage = Column(JSON, nullable=False)
    limits = Column(JSON, nullable=False)
    percents = Column(JSON, nullable=False)


@default_repr
class Template(Base):
    __tablename__ = 'template'
    id = Column(Integer, primary_key=True)
    name = Column(String(32), nullable=False)
    disk = Column(Integer, nullable=False)


@default_repr
class Ignored_Pools(Base):
    __tablename__ = 'ignored_pools'
    id = Column(String(32), primary_key=True)


@default_repr
class Allowed_Users(Base):
    __tablename__ = 'allowed_users'
    id = Column(String(32), primary_key=True)
