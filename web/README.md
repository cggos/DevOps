
```bash
python app.py

uwsgi --http 0.0.0.0:5001 -w app:app

curl 127.0.0.1:8000
```
