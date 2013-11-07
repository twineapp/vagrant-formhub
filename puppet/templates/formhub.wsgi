import os
import sys

sys.path.append('/var/www/formhub')

os.environ['DJANGO_SETTINGS_MODULE'] = 'formhub.preset.default_settings'

import django.core.handlers.wsgi
application = django.core.handlers.wsgi.WSGIHandler()
