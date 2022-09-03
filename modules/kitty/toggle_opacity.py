from typing import List
from kitty.boss import Boss
from kitty.fast_data_types import (
    background_opacity_of,
    change_background_opacity,
    get_options
)

def main(args: List[str]) -> str:
    pass

from kittens.tui.handler import result_handler
@result_handler(no_ui=True)
def handle_result(args: List[str], answer: str, target_window_id: int, boss: Boss) -> None:
    alt_opacity = float(args[1])
    w = boss.window_id_map.get(target_window_id)
    if w is None:
      return
    toggle_opacity(w.os_window_id, alt_opacity)

def toggle_opacity(os_window_id: int, alt_opacity: float) -> None:
    '''
    Toggles between default and alternate opacity
          usage: map cmd+p kitten toggle_opacity.py .5
    '''
    default_opacity = get_options().background_opacity
    if background_opacity_of(os_window_id) != default_opacity:
      target = default_opacity
    else:
      target = alt_opacity
    change_background_opacity(os_window_id, max(0.1, min(target, 1.0)))

