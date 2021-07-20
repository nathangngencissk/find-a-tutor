import datetime
import uuid

from sqlalchemy import Table, Column, String, Boolean, Integer, MetaData, ForeignKey, Numeric
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship

from utils.database import Database
from utils import object_to_dict, generate_qrcode

base = declarative_base()


class Course(base):

    __tablename__ = 'courses'

    id = Column(Integer, primary_key=True)
    name = Column(String)
    description = Column(String)
    short_description = Column(String)
    image = Column(String)
    price = Column(Numeric)
    status = Column(String)
    language_id = Column(Integer)
    category_id = Column(Integer)
    owner_id = Column(String)
    created_at = Column(String)
    updated_at = Column(String)