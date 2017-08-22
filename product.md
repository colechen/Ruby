### Compare puma, unicorn, passenger
http://blog.scoutapp.com/articles/2017/02/10/which-ruby-app-server-is-right-for-you
1. Request buffering
In the Ruby app server ecosystem, both Puma and Passenger handle slow clients(client request taking too long due to slow network) in a similar fashion: request buffering. A separate process downloads incoming requests. Only when the request has completed is it passed on to an available worker. Unicorn can pair with Nginx which buffer the client request.

2. Clustering
To process more requests concurrently, your app server must support clustering: it must spawn multiple processes to execute application code on the same host across multiple requests. All three supports clustering.

3. Multithread
The most efficient way to tackle slow I/O is multithreading. A worker process spawns several worker threads inside of it. Each request is handled by one of those threads, but when it pauses for I/O - like waiting on a db query - another thread starts its work. This rapid back & forth makes best use of your RAM limitations, and keeps your CPU busy.
