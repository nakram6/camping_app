import 'dart:math';

class QiblaService {
static const double kaabaLat =
21.4225;

static const double kaabaLon =
39.8262;

static double calculateQibla(
double latitude,
double longitude,
) {
final lat1 =
latitude * pi / 180;


final lon1 =
    longitude * pi / 180;

final lat2 =
    kaabaLat * pi / 180;

final lon2 =
    kaabaLon * pi / 180;

final y =
    sin(lon2 - lon1);

final x =
    cos(lat1) * tan(lat2) -
    sin(lat1) *
        cos(lon2 - lon1);

final bearing =
    atan2(y, x);

return (bearing * 180 / pi +
        360) %
    360;


}

static double distanceToKaaba(
double latitude,
double longitude,
) {
const earthRadius =
6371.0;


final dLat =
    (kaabaLat - latitude) *
    pi /
    180;

final dLon =
    (kaabaLon - longitude) *
    pi /
    180;

final a =
    sin(dLat / 2) *
            sin(dLat / 2) +
        cos(
              latitude *
                  pi /
                  180,
            ) *
            cos(
              kaabaLat *
                  pi /
                  180,
            ) *
            sin(dLon / 2) *
            sin(dLon / 2);

final c =
    2 *
        atan2(
          sqrt(a),
          sqrt(1 - a),
        );

return earthRadius * c;


}
}
