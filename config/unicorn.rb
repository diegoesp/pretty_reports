worker_processes 3                          # this should be >= nr_cpus
pid "./log/unicorn.pid"
# stderr_path "./log/unicorn.log"           # Redirect log to file
# stdout_path "./log/unicorn.log"           # Redirect log to file
# listen 3000                               # by default Unicorn listens on port 8080