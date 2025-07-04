if uwsm check may-start; then
    exec uwsm start dwl -- -s "uwsm finalize"
fi
