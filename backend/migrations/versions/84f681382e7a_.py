"""empty message

Revision ID: 84f681382e7a
Revises: 0c4e5718393e
Create Date: 2024-01-28 09:46:11.841809

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '84f681382e7a'
down_revision = '0c4e5718393e'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('destination',
    sa.Column('id', sa.Integer(), autoincrement=True, nullable=False),
    sa.Column('uid', sa.String(length=64), nullable=True),
    sa.Column('imgUrl', sa.String(length=128), nullable=True),
    sa.Column('name', sa.String(length=64), nullable=True),
    sa.Column('city', sa.String(length=64), nullable=True),
    sa.Column('price', sa.BIGINT(), nullable=True),
    sa.Column('rating', sa.Float(), nullable=True),
    sa.Column('is_new', sa.Boolean(), nullable=True),
    sa.Column('is_popular', sa.Boolean(), nullable=True),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('user',
    sa.Column('id', sa.Integer(), autoincrement=True, nullable=False),
    sa.Column('uid', sa.String(length=32), nullable=False),
    sa.Column('email', sa.String(length=64), nullable=False),
    sa.Column('password', sa.Text(), nullable=False),
    sa.Column('name', sa.String(length=64), nullable=False),
    sa.Column('hobby', sa.String(length=32), nullable=True),
    sa.Column('balance', sa.BIGINT(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('uid')
    )
    op.drop_table('user_model')
    op.drop_table('destination_model')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('destination_model',
    sa.Column('id', sa.INTEGER(), nullable=False),
    sa.Column('uid', sa.VARCHAR(length=64), nullable=True),
    sa.Column('imgUrl', sa.VARCHAR(length=128), nullable=True),
    sa.Column('name', sa.VARCHAR(length=64), nullable=True),
    sa.Column('city', sa.VARCHAR(length=64), nullable=True),
    sa.Column('price', sa.BIGINT(), nullable=True),
    sa.Column('rating', sa.FLOAT(), nullable=True),
    sa.Column('is_new', sa.BOOLEAN(), nullable=True),
    sa.Column('is_popular', sa.BOOLEAN(), nullable=True),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_table('user_model',
    sa.Column('id', sa.INTEGER(), nullable=False),
    sa.Column('uid', sa.VARCHAR(length=32), nullable=False),
    sa.Column('email', sa.VARCHAR(length=64), nullable=False),
    sa.Column('password', sa.TEXT(), nullable=False),
    sa.Column('name', sa.VARCHAR(length=64), nullable=False),
    sa.Column('hobby', sa.VARCHAR(length=32), nullable=True),
    sa.Column('balance', sa.BIGINT(), nullable=True),
    sa.PrimaryKeyConstraint('id'),
    sa.UniqueConstraint('uid')
    )
    op.drop_table('user')
    op.drop_table('destination')
    # ### end Alembic commands ###
