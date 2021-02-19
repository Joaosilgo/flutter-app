import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:convert' show utf8;

class ScanResultTile extends StatelessWidget {
  const ScanResultTile({Key key, this.result, this.onTap}) : super(key: key);

  final ScanResult result;
  final VoidCallback onTap;

  Widget _buildTitle(BuildContext context) {
    if (result.device.name.length > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            result.device.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
            ),
          ),
          Text(
            result.device.id.toString(),
            // style: Theme.of(context).textTheme.caption,
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
            ),
          ),
        ],
      );
    } else {
      return Text(result.device.id.toString(),
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w500,
            color: Colors.grey[400],
          ));
    }
  }

  Widget _buildAdvRow(BuildContext context, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey[400],
              )),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .apply(color: Colors.grey[400]),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  String getNiceHexArray(List<int> bytes) {
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]'
        .toUpperCase();
  }

  String getNiceManufacturerData(Map<int, List<int>> data) {
    if (data.isEmpty) {
      return null;
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add(
          '${id.toRadixString(16).toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  String getNiceServiceData(Map<String, List<int>> data) {
    if (data.isEmpty) {
      return null;
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add('${id.toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(
      dividerColor: Colors.transparent,
      accentColor: Colors.grey,
    );
    return Theme(
        data: theme,
        child: ExpansionTile(
          title: _buildTitle(context),
          leading: Text(result.rssi.toString(),
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey[400],
              )),
          trailing: ButtonTheme(
            minWidth: 75.0,
            height: 25.0,
            disabledColor: Colors.limeAccent[100],
            child: RaisedButton(
              child: Text('CONNECT',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              color: Colors.limeAccent[400],
              textColor: Colors.white,
              onPressed: (result.advertisementData.connectable) ? onTap : null,
              disabledColor: Colors.limeAccent[100],
            ),
          ),
          children: <Widget>[
            _buildAdvRow(context, 'Complete Local Name',
                result.advertisementData.localName),
            _buildAdvRow(context, 'Tx Power Level',
                '${result.advertisementData.txPowerLevel ?? 'N/A'}'),
            _buildAdvRow(
                context,
                'Manufacturer Data',
                getNiceManufacturerData(
                        result.advertisementData.manufacturerData) ??
                    'N/A'),
            _buildAdvRow(
                context,
                'Service UUIDs',
                (result.advertisementData.serviceUuids.isNotEmpty)
                    ? result.advertisementData.serviceUuids
                        .join(', ')
                        .toUpperCase()
                    : 'N/A'),
            _buildAdvRow(
                context,
                'Service Data',
                getNiceServiceData(result.advertisementData.serviceData) ??
                    'N/A'),
          ],
        ));
  }
}

class ServiceTile extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile> characteristicTiles;

  const ServiceTile({Key key, this.service, this.characteristicTiles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);

    if (characteristicTiles.length > 0) {
      print(service.characteristics);
      return Theme(
          data: theme,
          child: ExpansionTile(
            trailing: ButtonTheme(
              // minWidth: 75.0,
              // height: 25.0,
              disabledColor: Colors.limeAccent[100],
              child: IconButton(
                icon: Icon(Icons.maximize, color: Colors.grey),
                onPressed: null,
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Service',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[400],
                    )),
                Text(service.uuid.toString().toUpperCase(),
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[400],
                    )),
                /*
            Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Theme.of(context).textTheme.caption.color))
                    */
              ],
            ),
            children: characteristicTiles,
          ));
    } else {
      return ListTile(
        title: Text('Service'),
        subtitle:
            Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}'),
      );
    }
  }
}

class CharacteristicTile extends StatelessWidget {
  final BluetoothCharacteristic characteristic;
  final List<DescriptorTile> descriptorTiles;
  final VoidCallback onReadPressed;
  final VoidCallback onWritePressed;
  final VoidCallback onNotificationPressed;

  const CharacteristicTile(
      {Key key,
      this.characteristic,
      this.descriptorTiles,
      this.onReadPressed,
      this.onWritePressed,
      this.onNotificationPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
  //  if (characteristic.properties.notify) {
      return StreamBuilder<List<int>>(
        stream: characteristic.value,
        initialData: characteristic.lastValue,
        builder: (c, snapshot) {
          // final value = snapshot.data;
          final value = utf8.decode(snapshot.data);
         
        

          return ExpansionTile(
            title: ListTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Characteristic',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[400],
                      )),
                  Text(
                      '0x${characteristic.uuid.toString().toUpperCase().substring(4, 8)}',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[400],
                      )),
                  Text(characteristic.uuid.toString().toUpperCase(),
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[400],
                      ))
                  /*  style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Theme.of(context).textTheme.caption.color)),*/
                  /*  Text('Characteristic Properties: ' +
                    characteristic.properties.toString()) */
                ],
              ),
              subtitle: Text(value.toString(),
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[500],
                  )),
              contentPadding: EdgeInsets.all(0.0),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.menu_book,
                    color: Colors.grey[400],
                  ),
                  onPressed: onReadPressed,
                ),
                IconButton(
                  icon: Icon(Icons.celebration, color: Colors.grey[400]),
                  onPressed: onWritePressed,
                ),
                IconButton(
                  icon: Icon(
                      characteristic.isNotifying
                          ? Icons.notifications_active
                          : Icons.notifications_off,
                      semanticLabel: 'Notification',
                      color: Colors.grey[400]),
                  //  Theme.of(context).iconTheme.color.withOpacity(0.5)),
                  onPressed: onNotificationPressed,
                )
              ],
            ),
            children: descriptorTiles,
          );
        },
      );
    }
  }


class DescriptorTile extends StatelessWidget {
  final BluetoothDescriptor descriptor;
  final VoidCallback onReadPressed;
  final VoidCallback onWritePressed;

  const DescriptorTile(
      {Key key, this.descriptor, this.onReadPressed, this.onWritePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Descriptor',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
              )),
          Text('0x${descriptor.uuid.toString().toUpperCase().substring(4, 8)}',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
              ))
          /*  style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Theme.of(context).textTheme.caption.color))*/
        ],
      ),
      subtitle: StreamBuilder<List<int>>(
        stream: descriptor.value,
        initialData: descriptor.lastValue,
        builder: (c, snapshot) {
          //  final value = utf8.decode(snapshot.data);
          return Text(snapshot.data.toString(),
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
              ));
        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.get_app,
              color: Colors.grey[400],
            ),
            onPressed: onReadPressed,
          ),
          /*  IconButton(
            icon: Icon(
              Icons.file_upload,
              color: Theme.of(context).iconTheme.color.withOpacity(0.5),
            ),
            onPressed: onWritePressed,
          ) */
        ],
      ),
    );
  }
}
