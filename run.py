"""
Entry point for CampusConnect AI.

    python run.py            normal local server (http)
    python run.py --https    local server over https, for testing GPS on a phone

Why the https option exists: phones only allow GPS (and other sensors) on
secure pages. http://127.0.0.1 on the same computer counts as secure, but
http://192.168.x.x from your phone does NOT - so live GPS silently fails
there. --https gives the phone a secure page (it will show a one-time
"connection not private" warning because the certificate is self-made;
choose Advanced -> Proceed). Needs the 'cryptography' package
(run_phone_https.bat installs it for you).

Bound to 0.0.0.0 so other devices on the SAME Wi-Fi can reach it. This does
NOT expose it to the internet.
"""
import sys

from campusconnect import create_app

app = create_app()

if __name__ == "__main__":
    ssl_context = None
    if "--https" in sys.argv:
        try:
            import cryptography  # noqa: F401  (needed by Werkzeug's self-signed certs)
        except ImportError:
            print("The --https option needs the 'cryptography' package.")
            print("Install it with:  pip install cryptography")
            sys.exit(1)
        ssl_context = "adhoc"
    app.run(debug=True, host="0.0.0.0", port=5000, ssl_context=ssl_context)
