# My Idena

Idena iOS and Android app based on Flutter framework .

[![Build Status](https://travis-ci.com/redDwarf03/my-idena.svg?branch=master)](https://travis-ci.com/redDwarf03/my-idena)

## Configuration
##### for a Windows PC:
* execute **idena-go.exe** with ``--rpcaddr {ip_address} --rpcport {port_number}`` (don't run the windows client application)
* in the first launch, go to "Parameters" page
* type ``http://{ip_address}:{port_number}`` to connect to your node
* type the api.key (cf ``%appdata%\Idena\node\datadir\api.key``)

##### for a remote server and Android phone:
* install [Termux](https://play.google.com/store/apps/details?id=com.termux&hl=en) or equivalent on your Android phone
* install ssh ``pkg install openssh -y``
* setup tunnel connection using ssh ``ssh -L 9999:localhost:9009 YOUR_VPS_IP``
* open **my_idena**, go to "Parameters" page and type ``http://localhost:9999`` and your api key in the following file ``./datadir/api.key``

## Work in progress

## Help

Consider supporting my-idena by donating to **0xf429e36d68be10428d730784391589572ee0f72b**

## Tested with
|OS   |Model   | Resolution  | app-arm64-v8a | app-armeabi-v7a | app-x86_64
| :------------ | :------------ | ------------: | ------------: | ------------: | ------------: | 
| Android 5 (Lollipop)| Nexus 5 | 1080x1920 |  |  |  |
| Android 6.0.1 (Marshmallow) | Samsung Galaxy Note 4 | 1440x2560  | - | X | - |
| Android 7 (Nougat) | Orange Rise 52 | 480x854 | - | X | - |
| Android 7 (Nougat) | Nexus 4 |  786x1280 |  |  |  |
| Android 8.1 (Oréo) | Huawei P20 Pro |  1080x2240 | X | - | - |
| Android 9 (Pie) | Pixel 2 | 1080x1920 |  |  |  |
| Android 10 | Galaxy A40 | 1080x2340 | X | X | - |
| Android 10 | Galaxy A41 | 1080x2400 |  |  |  |
| Android 10+ | Pixel XL | 1440x2560 |  |  |  |

