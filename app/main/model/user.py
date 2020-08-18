
from .. import db, flask_bcrypt
import datetime
from app.main.model.blacklist import BlacklistToken
from ..config import key
import jwt

class User(db.Model):
	""" User Model for storing user related details """
	__tablename__ = "user"
	id = db.Column(db.Integer, primary_key=True, autoincrement=True)	
	first_name = db.Column(db.String(30), default='', nullable=False)
	middle_name = db.Column(db.String(30), default='', nullable=False)
	last_name = db.Column(db.String(30), default='', nullable=False)
	type_doc = db.Column(db.Integer, nullable=False)
	num_doc = db.Column(db.String(30), unique=True, nullable=False)
	id_country = db.Column(db.Integer, nullable=False)
	id_state = db.Column(db.Integer, nullable=False)
	id_city = db.Column(db.Integer, nullable=False)
	registered_on = db.Column(db.DateTime, nullable=False)
	sex = db.Column(db.String(1),nullable=False) 
	phone =db.Column(db.String(10),nullable=True)
	date_birth = db.Column(db.DateTime,nullable=False)
	
	@property
	def password(self):
		raise AttributeError('password: write-only field')
	
	@password.setter
	def password(self, password):
		self.password_hash = flask_bcrypt.generate_password_hash(password).decode('utf-8')
		
	def check_password(self, password):
		return flask_bcrypt.check_password_hash(self.password_hash, password)
	
	@staticmethod
	def encode_auth_token(user_id):
		"""
		Generates the Auth Token
		:return: string
		"""
		try:
			payload = {
				'exp': datetime.datetime.utcnow() + datetime.timedelta(days=1, seconds=5),
				'iat': datetime.datetime.utcnow(),
				'sub': user_id
			}
			return jwt.encode(
				payload,
				key,
				algorithm='HS256'
			)
		except Exception as e:
			return e
	
	@staticmethod
	def decode_auth_token(auth_token):
		"""
		Decodes the auth token
		:param auth_token:
		:return: integer|string
		"""
		try:
			payload = jwt.decode(auth_token, key)
			is_blacklisted_token = BlacklistToken.check_blacklist(auth_token)
			if is_blacklisted_token:
				return 'Token blacklisted. Please log in again.'
			else:
				return payload['sub']
		except jwt.ExpiredSignatureError:
			return 'Signature expired. Please log in again.'
		except jwt.InvalidTokenError:
			return 'Invalid token. Please log in again.'
	
	def __repr__(self):
		return "<User '{}'>".format(self.username)
