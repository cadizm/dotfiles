import atexit
import os

ip = get_ipython()
LIMIT = 1000 # limit the size of the history

def save_history():
    """save the IPython history to a plaintext file"""
    histfile = os.path.join(ip.profile_dir.location, "ipython_history.py")
    print("Saving plaintext history to %s" % histfile)
    lines = []
    # get previous lines
    # this is only necessary because we truncate the history,
    # otherwise we chould just open with mode='a'
    if os.path.exists(histfile):
        with open(histfile, 'r') as f:
            lines = f.readlines()

    # add any new lines from this session
    lines.extend(record[2] + '\n' for record in ip.history_manager.get_range())

    with open(histfile, 'w') as f:
        # limit to LIMIT entries
        f.writelines(lines[-LIMIT:])

# do the save at exit
atexit.register(save_history)
