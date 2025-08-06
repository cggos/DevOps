# uwsgi --http :8000 --wsgi-file uwsgi_test.py
# curl http://127.0.0.1:8000

def application(env, start_response):
    start_response('200 OK', [('Content-Type','text/html')])
    #return ["Hello World"] # python2
    return [b"Hello World"] # python3
