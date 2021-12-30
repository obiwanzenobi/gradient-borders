# Gradient borders

Various borders that use gradient instead of boring plain colors.

## Usage

### Box borders:

Change your container borders to use fancy gradients:
```dart
Container(
  width: 100,
  height: 100,
  decoration: BoxDecoration(
    border: const GradientBoxBorder(
      gradient: LinearGradient(colors: [Colors.blue, Colors.red]),
      width: 4,
    ),
    borderRadius: BorderRadius.circular(16)
  ),
),
```
Works with both: border radius, and with `BoxShape.circle`

![image](screenshots/box_borders.png)

### Input borders
TBW

### Sponsored by
[The Code Brothers](https://thecodebrothers.pl)