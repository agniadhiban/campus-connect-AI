"""
This script is now mostly a convenience check — CampusConnect AI creates its
own Master Admin account automatically the first time the app starts
(see campusconnect/__init__.py: _ensure_master_admin), using the
MASTER_ADMIN_EMAIL / MASTER_ADMIN_USERNAME / MASTER_ADMIN_PASSWORD /
MASTER_ADMIN_NAME values from your .env file. That happens whether you run
locally (python run.py) or on a host like Render.

Run this any time to confirm the account exists and see its login details:
    python seed.py
"""
from campusconnect import create_app
from campusconnect.models import User, Role

app = create_app()  # this alone already creates the master admin if needed

with app.app_context():
    existing = User.query.filter_by(role=Role.MASTER_ADMIN).first()
    if existing:
        print("Master admin account is ready:")
        print(f"  username: {existing.username}")
        print(f"  email:    {existing.email}")
        print("  password: whatever you set as MASTER_ADMIN_PASSWORD in .env")
    else:
        print("Something went wrong — no master admin account was created.")
