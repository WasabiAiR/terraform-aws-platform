# Monitoring your GrayMeta Platform Instance

## healthz

The platform has a microservice style architecture. Many of the individual services expose a health checking endpoint called `healthz`. These endpoints simply return either an HTTP 200 or HTTP 500 response with some data in JSON format for determining if the particular service is having an issue. See [healthz](https://github.com/jasonhancock/healthz) for more information.

An example request and response from a healthz endpoint:

```
$ curl -i https://example.com/healthz
HTTP/2 200 
content-type: application/json
x-frame-options: sameorigin
content-length: 312
date: Wed, 04 Sep 2019 17:22:55 GMT

{
    "app": {
        "metadata": {
            "build_version": "2.0.3824",
            "git_hash": "5d63cd9",
            "go_version": "go1.13"
        }
    },
    "auth_api": {},
    "base_url": {},
    "base_url-dns": {
        "metadata": {
            "ip": "127.0.0.1"
        }
    },
    "control_api": {},
    "data_api": {},
    "file_api": {},
    "scheduler_api": {},
    "usage_api": {}
}
```

Here we can see that there are no issues as the endpoint returned an HTTP 200. If there had been an issue we sould see an HTTP 500, similar to this:

```
$ curl -i https://example.com/healthz
HTTP/1.1 500 Internal Server Error
Content-Type: application/json
X-Frame-Options: sameorigin
Date: Wed, 04 Sep 2019 17:25:28 GMT
Content-Length: 371

{
    "app": {
        "metadata": {
            "build_version": "dev",
            "git_hash": "dev",
            "go_version": "go1.13"
        }
    },
    "auth_api": {},
    "base_url": {},
    "base_url-dns": {
        "metadata": {
            "ip": "127.0.0.1"
        }
    },
    "control_api": {},
    "data_api": {
        "error": "dial tcp 127.0.0.1:7003: connect: connection refused"
    },
    "file_api": {},
    "scheduler_api": {},
    "usage_api": {}
}
```

Here we see that one of the configured checks is returning an error.


The list of healthz endpoints to monitor include:

* `/api/control/healthz`
* `/api/data/healthz`
* `/api/oauth/healthz`
* `/api/scheduler/healthz`
* `/api/usage/healthz`
* `/files/healthz`
* `/healthz`

A Nagios/Icinga plugin exists for monitoring healthz endpoints: [nagios-healthz](https://github.com/jasonhancock/nagios-healthz)

## Preflight checks

Once your GrayMeta platform instance is up and running, it is important to verify that all configuration steps have been completed successfully. The platform has a built in set of checks to automatically check various things to ensure they are configured correctly. We call these checks "Preflight Checks".

Preflight Checks return a numeric status:

* 4 - Unknown - something went wrong and needs attention
* 3 - Something that needs attention and correction
* 2 - Something that needs attention, but the platform will continue to operate
* 1 - Everything is okay, this particular check doesn't need any attention

The preflight check endpoint is located at `{your endpoint}/api/data/v3/preflight`. An example response:

```json
[
    {
        "name": "Elasticsearch Cluster Status",
        "message": "Elasticsearch cluster is green",
        "status": 1
    }
]
```

Here we see that there was a single preflight check configured and that it returned a status of 1 which indicates that everything is okay.
