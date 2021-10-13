# Custom widgets

import warnings

from libqtile.utils import send_notification
from libqtile.widget import base, battery as qtile_battery, volume as qtile_volume
from libqtile.widget.battery import BatteryState, BatteryStatus

# Stolen from Built in widget with more characters to display: 
# https://docs.qtile.org/en/latest/_modules/libqtile/widget/battery.html#Battery
class MyBattery(base.ThreadPoolText):
    """A text-based battery monitoring widget currently supporting FreeBSD"""
    orientations = base.ORIENTATION_HORIZONTAL
    defaults = [
        ('charge_char', 'c', 'Character to indicate the battery is charging'),
        ('empty_char', 'x', 'Character to indicate the battery is empty'),
        ('low_char', 'l', 'Character to indicate the battery is low'),
        ('quarter_char', 'q', 'Character to indicate the battery around 25%'),
        ('half_char', 'h', 'Character to indicate the battery is around 50%'),
        ('three_quarters_char', 't', 'Character to indicate the battery around 75%'),
        ('full_char', '=', 'Character to indicate the battery is full'),
        ('unknown_char', '?', 'Character to indicate the battery status is unknown'),
        ('format', '{char} {percent:2.0%} {hour:d}:{min:02d} {watt:.2f} W', 'Display format'),
        ('show_short_text', True, 'Show "Full" or "Empty" rather than formated text'),
        ('low_percentage', 0.10, "Indicates when to use the low_foreground color 0 < x < 1"),
        ('low_foreground', 'FF0000', 'Font color on low battery'),
        ('update_interval', 60, 'Seconds between status updates'),
        ('battery', 0, 'Which battery should be monitored (battery number or name)'),
        ('notify_below', None, 'Send a notification below this battery level.'),
    ]

    def __init__(self, **config) -> None:
        if "update_delay" in config:
            warnings.warn("Change from using update_delay to update_interval for battery widget, removed in 0.15",
                          DeprecationWarning)
            config["update_interval"] = config.pop("update_delay")

        base.ThreadPoolText.__init__(self, "", **config)
        self.add_defaults(self.defaults)

        self._battery = self._load_battery(**config)
        self._has_notified = False

    @staticmethod
    def _load_battery(**config):
        """Function used to load the Battery object

        Battery behavior can be changed by overloading this function in a base
        class.
        """
        return qtile_battery.load_battery(**config)

    def poll(self) -> str:
        """Determine the text to display

        Function returning a string with battery information to display on the
        status bar. Should only use the public interface in _Battery to get
        necessary information for constructing the string.
        """
        try:
            status = self._battery.update_status()
        except RuntimeError as e:
            return 'Error: {}'.format(e)

        if self.notify_below:
            percent = int(status.percent * 100)
            if percent < self.notify_below:
                if not self._has_notified:
                    send_notification("Warning", "Battery at {0}%".format(percent), urgent=True)
                    self._has_notified = True
            elif self._has_notified:
                self._has_notified = False

        return self.build_string(status)

    def build_string(self, status: BatteryStatus) -> str:
        """Determine the string to return for the given battery state

        Parameters
        ----------
        status:
            The current status of the battery

        Returns
        -------
        str
            The string to display for the current status.
        """
        if self.layout is not None:
            if status.state == BatteryState.DISCHARGING and status.percent < self.low_percentage:
                self.layout.colour = self.low_foreground
            else:
                self.layout.colour = self.foreground

        if status.state == qtile_battery.BatteryState.CHARGING:
            char = self.charge_char
        elif status.percent < .1:
            char = self.empty_char
        elif status.percent < .18:
            char = self.low_char
        elif status.percent < .35:
            char = self.quarter_char
        elif status.percent < .65:
            char = self.half_char
        elif status.percent < .95:
            char = self.three_quarters_char
        elif status.state == BatteryState.FULL:
            char = self.full_char
        else:
            char = self.unknown_char

        hour = status.time // 3600
        minute = (status.time // 60) % 60

        return self.format.format(
            char=char,
            percent=status.percent,
            watt=status.power,
            hour=hour,
            min=minute
        )
"""
# Stolen from Built in widget with more characters to display: 
# https://docs.qtile.org/en/latest/_modules/libqtile/widget/volume.html#Volume
class MyVolume(qtile_volume.Volume):
    class Volume(base._TextBox):
    orientations = base.ORIENTATION_HORIZONTAL
    defaults = [
        ("volume_low", None, "Character when volume is low"),
        ("volume_medium", None, "Character when volume is medium"),
        ("volume_high", None, "Character when volume is high"),
        ("volume_muted", None, "Character when volume is muted"),
        ("cardid", None, "Card Id"),
        ("device", "default", "Device Name"),
        ("channel", "Master", "Channel"),
        ("padding", 3, "Padding left and right. Calculated if None."),
        ("update_interval", 0.2, "Update time in seconds."),
        ("volume_app", None, "App to control volume"),
        ("step", 2, "Volume change for up an down commands in percentage."
                    "Only used if ``volume_up_command`` and ``volume_down_command`` are not set.")
    ]

    def __init__(self, **config):
        base._TextBox.__init__(self, '0', width=bar.CALCULATED, **config)
        self.add_defaults(Volume.defaults)
        if self.theme_path:
            self.length_type = bar.STATIC
            self.length = 0
        self.surfaces = {}
        self.volume = None

        self.add_callbacks({
            'Button1': self.cmd_mute,
            'Button3': self.cmd_run_app,
            'Button4': self.cmd_increase_vol,
            'Button5': self.cmd_decrease_vol,
        })
"""
