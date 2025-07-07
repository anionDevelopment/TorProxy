# TorProxy-reference

## Examples

See `Examples/MinimalDockerComposeFile/docker-compose.yml` for an example docker-compose-file for this image.

## Hints

### Permissions of configuration-file

The folder and the files contained in the folder which will be mounted in `/var/lib/tor` in the container must be owned by root on the host-system because Tor checks a permission.
There is no way to disable the permission-check.
If another user than root is the owner of the file then the following error may occur.

```
[warn] /var/lib/tor/myservice is not owned by this user (root, 0) but by <unknown> (1000). Perhaps you are running Tor as the wrong user?
[warn] Failed to parse/validate config: Failed to configure rendezvous options. See logs for details.
[err] Reading config failed--see warnings above.
```

If using `./Volumes/Keys` on the host as folder for the "keys" like in the example in `Examples/MinimalDockerComposeFile/docker-compose.yml` then a simple `chown -R root:root ./Volumes/Keys` should fix this issue.
