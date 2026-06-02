````markdown
# Day 15 – Networking Concepts: DNS, IP, Subnets & Ports

## Objective

Today I learned the core networking concepts every DevOps engineer should understand:

- DNS resolution
- IPv4 addressing
- Public vs Private IPs
- CIDR & subnetting basics
- Common networking ports
- Service communication troubleshooting

---

# Task 1 – DNS: How Names Become IPs

## What happens when we type google.com in a browser?

When we type `google.com` in a browser, the system first checks if the IP is already cached locally.  
If not, it sends a DNS request to a DNS server to find the IP address associated with the domain name.  
The DNS server returns the IP address, and the browser uses that IP to connect to Google's server.  
After the connection is established, the webpage loads in the browser.

---

## DNS Record Types

| Record Type | Purpose |
|---|---|
| A | Maps a domain name to an IPv4 address |
| AAAA | Maps a domain name to an IPv6 address |
| CNAME | Creates an alias from one domain to another |
| MX | Specifies mail servers for receiving emails |
| NS | Specifies the authoritative name servers for a domain |

---

## Command Used

```bash
dig google.com
````

## Sample Output

```bash
;; ANSWER SECTION:
google.com.        300     IN      A       142.250.183.14
```

### Identified Values

* A Record IP: `142.250.183.14`
* TTL: `300`

---

# Task 2 – IP Addressing

## What is an IPv4 Address?

An IPv4 address is a unique numerical identifier assigned to devices in a network.
It consists of 4 octets separated by dots.
Each octet ranges from 0 to 255.

Example:

```bash
192.168.1.10
```

---

## Public vs Private IP Address

| Type       | Description                        | Example     |
| ---------- | ---------------------------------- | ----------- |
| Public IP  | Accessible over the internet       | 8.8.8.8     |
| Private IP | Used inside local/private networks | 192.168.1.5 |

---

## Private IP Ranges

```bash
10.0.0.0 – 10.255.255.255
172.16.0.0 – 172.31.255.255
192.168.0.0 – 192.168.255.255
```

---

## Command Used

```bash
ip addr show
```

## Sample Output

```bash
inet 172.31.25.140/20 brd 172.31.31.255 scope global eth0
```

### Identified Private IP

```bash
172.31.25.140
```

This is a private IP because it belongs to the `172.16.x.x – 172.31.x.x` private range.

---

# Task 3 – CIDR & Subnetting

## What does /24 mean?

`/24` means the first 24 bits are used for the network portion of the address.
The remaining 8 bits are used for host addresses.

Example:

```bash
192.168.1.0/24
```

Subnet Mask:

```bash
255.255.255.0
```

---

## Usable Hosts

| CIDR | Total IPs | Usable Hosts |
| ---- | --------- | ------------ |
| /24  | 256       | 254          |
| /16  | 65,536    | 65,534       |
| /28  | 16        | 14           |

---

## Why do we subnet?

Subnetting helps divide a large network into smaller networks.
This improves organization, security, and performance.
It also reduces unnecessary broadcast traffic and helps manage IP addresses efficiently.

---

## CIDR Table

| CIDR | Subnet Mask     | Total IPs | Usable Hosts |
| ---- | --------------- | --------- | ------------ |
| /24  | 255.255.255.0   | 256       | 254          |
| /16  | 255.255.0.0     | 65,536    | 65,534       |
| /28  | 255.255.255.240 | 16        | 14           |

---

# Task 4 – Ports: The Doors to Services

## What is a Port?

A port is a logical communication endpoint used by services and applications.
Ports help the operating system identify which service should receive incoming network traffic.

---

## Common Ports

| Port  | Service |
| ----- | ------- |
| 22    | SSH     |
| 80    | HTTP    |
| 443   | HTTPS   |
| 53    | DNS     |
| 3306  | MySQL   |
| 6379  | Redis   |
| 27017 | MongoDB |

---

## Command Used

```bash
ss -tulpn
```

## Sample Output

```bash
tcp   LISTEN  0  128  0.0.0.0:22      0.0.0.0:*    users:(("sshd",pid=700,fd=3))

tcp   LISTEN  0  80   127.0.0.1:3306  0.0.0.0:*    users:(("mysqld",pid=820,fd=20))
```

---

## Matched Services

| Port | Service                 |
| ---- | ----------------------- |
| 22   | SSH Server (sshd)       |
| 3306 | MySQL Database (mysqld) |

---

# Task 5 – Putting It Together

## Scenario 1

### Command

```bash
curl http://myapp.com:8080
```

### Networking Concepts Involved

First, DNS resolves `myapp.com` into an IP address.
Then the system connects to port `8080` on the server using TCP/IP networking.
The HTTP request is sent to the service listening on port `8080`.

---

## Scenario 2

### Problem

Application cannot connect to database at:

```bash
10.0.1.50:3306
```

### Things to Check First

* Verify the database service is running
* Check if port `3306` is open and listening
* Confirm network connectivity using `ping` or `telnet`
* Verify firewall or security group rules
* Ensure the IP address is correct and reachable

---

# Key Learnings

1. DNS converts human-readable domain names into IP addresses.
2. CIDR notation helps define network size and available hosts.
3. Ports allow multiple services to communicate on the same machine.

---

# Commands Practiced

```bash
dig google.com

ip addr show

ss -tulpn
```

---

# Conclusion

Today’s networking concepts helped me understand how systems communicate over networks.
I learned how DNS resolution works, how IP addressing and subnetting organize networks, and how ports allow services to communicate securely and efficiently.

---

```
```

