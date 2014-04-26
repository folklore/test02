# Be sure to restart your server when you modify this file.

Vladimir::Application.config.session_store :redis_store,
                                            'redis://rediscloud:M44rEgcHiIL1qmVw@pub-redis-19464.us-east-1-2.1.ec2.garantiadata.com:19464',
                                            { expires_in: 90.minutes }