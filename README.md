# CampusConnect AI — Setup & Run Guide

This project is scoped to **local development only**: SQLite storage,
Flask's built-in dev server, running on your own computer at
`http://127.0.0.1:5000`. It can also run on a free host (see "Put it
online" below) for real any-device access.

CampusConnect AI supports **multiple colleges in one deployment**. The
Master Admin account (you) oversees every college; each college's own
admins and students only ever see their own college's data — complaints,
lost & found, SOS alerts, announcements, and tips never cross between
colleges. See "Setting up multiple colleges" below.

## Quick Start (Windows, no typing required)

1. Make sure Python is installed (see Prerequisites below).
2. Double-click **`setup.bat`**. Follow what it says on screen — it will
   pause once and ask you to edit the `.env` file it creates (set your own
   `SECRET_KEY`; the Master Admin email/username/password are already
   filled in for you, change the password before going live).
3. Once it says "Setup complete!", double-click **`run.bat`**.
4. Open `http://127.0.0.1:5000` in your browser.
5. Log in with the Master Admin username and password from your `.env`.
6. Add your first college (see "Setting up multiple colleges" below)
   before anyone can create an admin account or a student can register.

From then on, every time you want to use the app: just double-click
`run.bat` again. You only need `setup.bat` once.

---

## Setting up multiple colleges

1. Log in as the Master Admin.
2. Click **Colleges** in the top navigation → **+ Add College**.
3. Give it a name (and an optional short code). Repeat for each institution.
4. Click **Manage Admins** → **+ Create Admin**, and pick which college
   that admin belongs to. That admin will only ever see their own
   college's complaints, SOS alerts, lost & found, and tips.
5. Share the registration link with students — when they sign up, they
   pick their own college from a dropdown. They'll only ever see their
   own college's data too.

As Master Admin, you can see and manage everything across every college:
every complaint, every SOS alert, every admin and student account, and
you can post announcements either to one college or to all of them at
once ("All colleges (global)" when posting).

**If you're upgrading from an older copy of this project:** the database
structure changed to support colleges. Delete your old `campusconnect.db`
file (back it up first if you want to keep old data) and run `setup.bat` /
`seed.py` again — the app will rebuild it and recreate your Master Admin
account automatically.

---

## Manual Setup (typing commands yourself, any OS)

### 1. Prerequisites
- Python 3.10+ installed

### 2. Get the project onto your machine
Unzip the project folder anywhere, e.g. `C:\campusconnect` or `~/campusconnect`.

### 3. Create a virtual environment
Open a terminal **inside the project folder** and run:
```bash
python -m venv venv
```
Activate it:
- Windows: `venv\Scripts\activate`
- Mac/Linux: `source venv/bin/activate`

You'll see `(venv)` appear at the start of your terminal prompt when it's active.

### 4. Install dependencies
```bash
pip install -r requirements.txt
```

### 5. Set up environment variables
Copy the example env file:
- Windows: `copy .env.example .env`
- Mac/Linux: `cp .env.example .env`

Open `.env` and change `SECRET_KEY` to any random string, and set your own
`MASTER_ADMIN_PASSWORD`.

### 6. Create the database + Master Admin account
```bash
python seed.py
```
This creates `campusconnect.db` (a SQLite file) and automatically sets up
your Master Admin login using the MASTER_ADMIN_* values in your `.env`.

### 7. Run the app
```bash
python run.py
```
You'll see `Running on http://127.0.0.1:5000`. Open that URL in your browser.

### 8. Log in
- **Master Admin**: the username from `MASTER_ADMIN_USERNAME` in your `.env`
  (default: `Adhiban`), password from `MASTER_ADMIN_PASSWORD`.
- **Students**: click "Create an account" on the login page to self-register.
- **Admin/Staff accounts**: log in as Master Admin → "Manage Admins" → create
  an admin account and tick which permissions they get.

### 9. Re-running later
Once set up, you only ever need:
```bash
venv\Scripts\activate   # (or: source venv/bin/activate  on Mac/Linux)
python run.py
```

---

---

## Using it on your phone (same Wi-Fi)

Your phone and computer must be on the **same Wi-Fi network**. This can be
unreliable — if your computer goes to sleep, its address changes, or you're
on a network that blocks device-to-device connections (common on campus
Wi-Fi), it will stop working. See "Put it online" below for a fix that
doesn't have this problem.

1. Double-click `run.bat` (or run `python run.py`) as usual.
2. Look at the black window — it now shows two addresses:
   ```
   On THIS computer, open:      http://127.0.0.1:5000
   On your PHONE (same Wi-Fi):  http://192.168.x.x:5000
   ```
3. On your phone, open its web browser and type in that second address
   (the one with numbers, not `127.0.0.1`).
4. Log in as normal.

**Make it look like an app icon:** once it's open on your phone browser,
use the browser menu → "Add to Home Screen".

---

## Put it online (works from any device, anywhere)

This makes the app reachable from any phone or computer with internet —
not just your own Wi-Fi, and it keeps working even when your laptop is off.
We'll use **Render** (free, no credit card needed for this tier).

The project is already set up for this — you just need two accounts and a
few clicks. No command line, no Git knowledge needed.

### Step 1 — Put the code on GitHub
1. Go to [github.com](https://github.com) and create a free account if you
   don't have one.
2. Click the **+** icon (top right) → **New repository**.
3. Name it `campusconnect-ai`, keep it **Public**, click **Create repository**.
4. On the new repo page, click **"uploading an existing file"**.
5. Drag your whole `campusconnect` project folder's contents into the
   browser window (all the files and folders — `campusconnect/`,
   `templates/`, `static/`, `run.py`, `requirements.txt`, `Procfile`,
   `render.yaml`, etc.). GitHub uploads them all.
6. Click **Commit changes** at the bottom.

Do NOT upload your `.env` file or `campusconnect.db` — those are your
personal local settings and data, not part of the app itself. If you see
them in the upload list, remove them first.

### Step 2 — Deploy on Render
1. Go to [render.com](https://render.com) and sign up (you can sign up
   directly with your new GitHub account — it's one click and links them
   automatically).
2. Click **New +** → **Blueprint**.
3. Choose the `campusconnect-ai` repository you just created.
4. Render reads the `render.yaml` file already in the project and fills
   in the setup for you. It will ask you to set `MASTER_ADMIN_PASSWORD` —
   type your own password here (this becomes your admin login).
5. Click **Apply** / **Create**.
6. Wait 2–5 minutes while it builds. When it's done, Render shows you a
   public web address like `https://campusconnect-ai.onrender.com`.

### Step 3 — Log in
Open that address from **any device, anywhere**. Log in with:
- the username in your `.env` (default: `Adhiban`)
- password: whatever you set in Step 2.4

### Good to know about the free tier
- The free service "sleeps" after 15 minutes with no visitors. The next
  visit takes 30–60 seconds to wake up — this is normal, not a bug.
- The database on the free tier resets whenever the service restarts
  (goes to sleep and wakes up, or you redeploy). This is fine for demos
  and coursework, but don't rely on it for data you need to keep forever.
  If you need that later, Render also offers a persistent database add-on
  you can connect to this same project without any code changes.

## Notes
- Uploaded photos are saved to `static/uploads/` locally.
- To reset all data: stop the app, delete `campusconnect.db`, then run
  `python seed.py` again.
- This build is intentionally dev-only. It is not configured for production
  hosting (no HTTPS, no production database, no production WSGI server).
