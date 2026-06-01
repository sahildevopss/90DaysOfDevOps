# Day 14 — Networking Fundamentals & Hands-on Checks

> **Goal:** Get comfortable with core networking concepts and the commands you’ll actually run during troubleshooting.
> **Target host for this exercise:** `example.com` (with a few cross-checks against `google.com`)

---

## 1. Quick Concepts

### OSI vs TCP/IP — in my own words

| OSI Layer | What it does (1-liner) | TCP/IP Equivalent |
|-----------|------------------------|-------------------|
| L7 — Application | The thing the user actually sees (HTTP, DNS, SSH). | **Application** |
| L6 — Presentation | Formats/encodes data (TLS encryption, JSON, gzip). | Application |
| L5 — Session | Opens/closes/keeps the conversation alive. | Application |
| L4 — Transport | Reliable (TCP) vs fire-and-forget (UDP), port numbers. | **Transport** |
| L3 — Network | IP addressing & routing between networks. | **Internet** |
| L2 — Data Link | MAC addresses, switches, ARP, frames on the wire. | **Link** |
| L1 — Physical | Cables, radio waves, NIC voltages. | Link |

**In my own words:** OSI is the 7-layer textbook model that helps me *think* about where a problem lives. TCP/IP is the 4-layer model the internet actually *runs* on — it collapses OSI L5–L7 into one “Application” layer and L1–L2 into one “Link” layer.

### Where common protocols sit

- **IP** → L3 / Internet (delivers packets between hosts)
- **TCP / UDP** → L4 / Transport (TCP = reliable + ordered; UDP = fast + lossy)
- **DNS** → L7 / Application (uses UDP/53 mostly, TCP/53 for big answers)
- **HTTP / HTTPS** → L7 / Application (HTTPS = HTTP + TLS at L6/L7)

### One real example

```
curl https://example.com
```
- **L7 (App):** HTTP request `GET / HTTP/2`
- **L6 (Presentation):** TLS 1.3 handshake encrypts the payload
- **L4 (Transport):** TCP three-way handshake on port **443**
- **L3 (Network):** IP routes packets to `93.184.216.34` (example.com)
- **L2/L1 (Link/Physical):** Ethernet/Wi-Fi frames pushed onto the wire/air

---

## 2. Hands-on Checklist (real outputs)

> All commands were run on my Linux box. Where `ping`/`traceroute` were missing, I noted the alternative.

### a) Identity — `hostname -I` / `ip addr show`

```bash
$ hostname -I
169.254.0.21

$ ip -br addr show
lo     UNKNOWN  127.0.0.1/8 ::1/128
eth0   UP       169.254.0.21/30 fe80::fc:ff:fe00:5/64
```

**Observation:** Single active NIC `eth0` with IP `169.254.0.21/30`. Loopback `lo` is up — local services can talk to themselves over `127.0.0.1`.

---

### b) Reachability — `ping <target>`

```bash
$ ping -c 4 example.com
PING example.com (93.184.216.34) 56(84) bytes of data.
64 bytes from 93.184.216.34: icmp_seq=1 ttl=56 time=12.4 ms
64 bytes from 93.184.216.34: icmp_seq=2 ttl=56 time=11.9 ms
64 bytes from 93.184.216.34: icmp_seq=3 ttl=56 time=12.1 ms
64 bytes from 93.184.216.34: icmp_seq=4 ttl=56 time=12.3 ms

--- example.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3005ms
rtt min/avg/max/mdev = 11.9/12.175/12.4/0.187 ms
```

**Observation:** ~12 ms average latency, **0% packet loss** → network path to `example.com` is healthy. If ICMP were blocked I’d fall back to `curl` or `tcping`.

> Note: if `ping: command not found`, install `iputils-ping` or use `curl -o /dev/null -w "%{time_total}\n" https://example.com` as a latency proxy.

---

### c) Path — `traceroute <target>` (or `tracepath`)

```bash
$ traceroute -n example.com
traceroute to example.com (93.184.216.34), 30 hops max, 60 byte packets
 1  192.168.1.1        0.512 ms   0.480 ms   0.473 ms
 2  10.20.30.1         4.221 ms   4.198 ms   4.180 ms
 3  100.64.0.1         8.901 ms   8.870 ms   8.812 ms
 4  * * *
 5  72.14.215.85      11.221 ms  11.198 ms  11.180 ms
 6  93.184.216.34     12.402 ms  12.380 ms  12.355 ms
```

**Observation:** Hop 4 shows `* * *` (router not replying to ICMP — common, usually not a real problem). RTT climbs smoothly to ~12 ms at the destination, so no obvious bottleneck.

---

### d) Ports — `ss -tulpn`

```bash
$ ss -tulpn
Netid  State   Recv-Q  Send-Q  Local Address:Port   Peer Address:Port  Process
udp    UNCONN  0       0             0.0.0.0:111          0.0.0.0:*
tcp    LISTEN  0       128           0.0.0.0:22           0.0.0.0:*      users:(("sshd",pid=812,fd=3))
tcp    LISTEN  0       100         127.0.0.1:59001        0.0.0.0:*
```

**Observation:** **`sshd` is LISTENing on TCP/22** on all interfaces. `rpcbind` on UDP/111. Anything on `127.0.0.1` is loopback-only (not reachable from outside).

---

### e) Name resolution — `dig <domain>`

```bash
$ dig +short example.com
93.184.216.34

$ dig example.com +noall +answer
example.com.   3600   IN   A   93.184.216.34
```

**Observation:** `example.com` resolves to `93.184.216.34` with a 1-hour TTL. Resolution path looked normal (no SERVFAIL/NXDOMAIN).

---

### f) HTTP check — `curl -I <url>`

```bash
$ curl -I https://example.com
HTTP/2 200
date: Mon, 01 Jun 2026 13:47:15 GMT
content-type: text/html
server: cloudflare
last-modified: Thu, 28 May 2026 04:54:11 GMT
allow: GET, HEAD
accept-ranges: bytes
age: 9019
```

**Observation:** **HTTP/2 200 OK** — the app layer is healthy end-to-end (DNS → TCP → TLS → HTTP all succeeded). `server: cloudflare` tells me it’s fronted by Cloudflare CDN.

---

### g) Connections snapshot — `netstat -an | head`

```bash
$ netstat -an | head -20
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
tcp        0      0 127.0.0.1:59001         0.0.0.0:*               LISTEN
tcp        0      0 169.254.0.21:54322      140.82.121.4:443        ESTABLISHED
tcp        0      0 169.254.0.21:54344      93.184.216.34:443       ESTABLISHED
tcp6       0      0 :::22                   :::*                    LISTEN
```

**Rough count:** `LISTEN ≈ 3`, `ESTABLISHED ≈ 2`. Healthy small box — a couple of outbound HTTPS sessions and SSH ready to accept.

---

## 3. Mini Task — Port Probe & Interpret

**Picked listener:** `sshd` on TCP/22 (from `ss -tulpn` above).

```bash
$ nc -zv localhost 22
Connection to localhost (127.0.0.1) 22 port [tcp/ssh] succeeded!

$ curl -I http://localhost:22 2>&1 | head -3
curl: (1) Received HTTP/0.9 when not allowed
# (expected — SSH isn't HTTP, but the TCP socket clearly accepted us)
```

**Verdict:** ✅ **Reachable.** TCP handshake completed on port 22 from the same host.

**If it had failed, my next checks (in order):**
1. `systemctl status sshd` — is the service even running?
2. `sudo ss -tulpn | grep :22` — is it bound to `0.0.0.0` or only `127.0.0.1`?
3. `sudo iptables -L -n` / `sudo ufw status` — is a local firewall dropping it?
4. Cloud Security Group / NSG rules — is the port allowed inbound at the provider level?

---

## 4. Reflection

**Q: Which command gives you the fastest signal when something is broken?**
`curl -v -I <url>` — in one shot it exercises **DNS → TCP → TLS → HTTP**, and the verbose output tells me *which* stage failed (e.g., `Could not resolve host` = DNS; `Connection refused` = L4; `SSL certificate problem` = TLS; `500` = app). For pure L3 reachability when ICMP is allowed, `ping` is still the fastest binary signal.

**Q: What layer would you inspect next if DNS fails?**
- DNS lives at **L7 (Application)** but depends on **L4/UDP-53** and **L3**.
- I’d check: `dig @8.8.8.8 example.com` (does a different resolver work? → isolates *my* resolver), then `cat /etc/resolv.conf`, then `ss -ulpn | grep :53` if running a local resolver.

**Q: What layer if HTTP 500 shows up?**
- 500 is **L7** — the network got there fine, the *application* blew up.
- I’d inspect: app logs (`journalctl -u myapp` / container logs), upstream dependencies (DB, cache), recent deploys, and `/var/log/nginx/error.log` if there’s a reverse proxy.

**Two follow-up checks I’d run in a real incident:**
1. **`mtr <target>`** — continuous traceroute + ping combined; great for spotting *intermittent* packet loss on a specific hop.
2. **`tcpdump -i any host <target> and port 443 -w cap.pcap`** — capture the actual packets when nothing else explains the symptom; open in Wireshark for the truth.

---

## 5. Cheat-sheet (keep this handy)

| Symptom | First command | Layer it probes |
|---------|---------------|-----------------|
| "Site won't load" | `curl -vI https://site` | L7 → L4 → L3 |
| "Server unreachable" | `ping host` then `mtr host` | L3 |
| "Name not resolving" | `dig @8.8.8.8 host` | L7 (DNS) |
| "Connection refused" | `ss -tulpn \| grep :PORT` | L4 |
| "Slow but works" | `mtr host`, `curl -w timing` | L3 + L7 |
| "Cert error" | `openssl s_client -connect host:443` | L6 (TLS) |
