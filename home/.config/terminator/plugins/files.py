# Clickable Files by nofxx
"""files.py - Clickable Files URIs open in Emacs"""
import re, os, subprocess, inspect
import terminatorlib.plugin as plugin
# from terminatorlib import plugin
# from terminatorlib import config

# Every plugin you want Terminator to load *must* be listed in 'AVAILABLE'
AVAILABLE = ['FileURLHandler']
 
class FileURLHandler(plugin.URLHandler):
    capabilities = ['url_handler']
    handler_name = 'file_path'

    # Match any non-space string starting with an alphanumericm or a slash
    # and ending with a colon followed by a number
    match = r'[a-zA-Z0-9\.\/][^ ]+:[[:digit:]]+|[a-zA-Z0-9\/][^ ]+\([[:digit:]]+\)'

    # Get current terminator path
    # Thanks to https://github.com/mchelem/terminator-grep-plugin/
    def get_cwd(self):
        """ Return current working directory. """
        # HACK: Because the current working directory is not available to plugins,
        # we need to use the inspect module to climb up the stack to the Terminal
        # object and call get_cwd() from there.
        for frameinfo in inspect.stack():
            frameobj = frameinfo[0].f_locals.get('self')
            if frameobj and frameobj.__class__.__name__ == 'Terminal':
                return frameobj.get_cwd()
        return None

    def callback(self, url):
        # Change file(N) to file:N
        url = re.sub('[\)]', '', re.sub('[\(]', ':', url))
        # Change file#N to file:N
        url = re.sub('[#]', ':', url)
        # Split result match file:line:col
        params = url.split(':')
        if len(params) == 3:
          fname, line, col = params
          opts = "+" + line + ":" + col
        else:
          fname, line = params
          opts = "+" + line
        if(fname[0] != '/'):
          fname = os.path.join(self.get_cwd(), fname)
        print "Opening..." + fname + "#" + opts
        subprocess.call(["emacsclient", "-n", opts, fname])
        return "some_nice_shining_string"
