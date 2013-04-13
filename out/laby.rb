
require "scanf.rb"




def can_open_right( state, x, y )
    return ((x < (state["sizeX"] - 1)) && state["cases"][x + 1][y]["free"]);
end

def can_open_left( state, x, y )
    return ((x > 0) && state["cases"][x - 1][y]["free"]);
end

def can_open_bottom( state, x, y )
    return ((y < (state["sizeY"] - 1)) && state["cases"][x][y + 1]["free"]);
end

def can_open_top( state, x, y )
    return ((y > 0) && state["cases"][x][y - 1]["free"]);
end

def open_left( state, x, y )
    state["cases"][x - 1][y]["right"] = false;
    state["cases"][x][y]["left"] = false;
    state["cases"][x - 1][y]["free"] = false;
    state["cases"][x][y]["free"] = false;
end

def open_right( state, x, y )
    state["cases"][x][y]["right"] = false;
    state["cases"][x + 1][y]["left"] = false;
    state["cases"][x][y]["free"] = false;
    state["cases"][x + 1][y]["free"] = false;
end

def open_top( state, x, y )
    state["cases"][x][y - 1]["bottom"] = false;
    state["cases"][x][y]["top"] = false;
    state["cases"][x][y - 1]["free"] = false;
    state["cases"][x][y]["free"] = false;
end

def open_bottom( state, x, y )
    state["cases"][x][y + 1]["top"] = false;
    state["cases"][x][y]["bottom"] = false;
    state["cases"][x][y + 1]["free"] = false;
    state["cases"][x][y]["free"] = false;
end

def init( x, y )
    cases = [];
    for i in (0 ..  x - 1) do
      cases_x = [];
      for j in (0 ..  y - 1) do
        reco = {"left" => true,
                "right" => true,
                "top" => true,
                "bottom" => true,
                "free" => true};
        cases_x[j] = reco;
      end
      cases[i] = cases_x;
    end
    out_ = {"sizeX" => x,
            "sizeY" => y,
            "cases" => cases};
    return (out_);
end

def print_lab( l )
    for x in (0 ..  l["sizeX"] - 1) do
      printf "%s", "__"
    end
    printf "%s", "\n"
    for y in (0 ..  l["sizeY"] - 1) do
      for x in (0 ..  l["sizeX"] - 1) do
        if l["cases"][x][y]["left"] then
          if l["cases"][x][y]["bottom"] then
            printf "%s", "|_"
          else
            printf "%s", "| "
          end
        elsif l["cases"][x][y]["bottom"] then
          printf "%s", "__"
        else
          printf "%s", "  "
        end
      end
      printf "%s", "|\n"
    end
    printf "%s", "\n"
end

def gen( lab, x, y )
    n = 4
    order = [];
    for i in (0 ..  n - 1) do
      order[i] = i;
    end
    for i in (0 ..  2) do
      j = 4 -
i
      k = order[i]
      order[i] = order[j];
      order[j] = k;
    end
    for i in (0 ..  3) do
      if (0 == order[i]) && can_open_left(lab, x, y) then
        open_left(lab, x, y);
        gen(lab, x - 1, y);
      end
      if (1 == order[i]) && can_open_right(lab, x, y) then
        open_right(lab, x, y);
        gen(lab, x + 1, y);
      end
      if (2 == order[i]) && can_open_top(lab, x, y) then
        open_top(lab, x, y);
        gen(lab, x, y - 1);
      end
      if (3 == order[i]) && can_open_bottom(lab, x, y) then
        open_bottom(lab, x, y);
        gen(lab, x, y + 1);
      end
    end
end

lab = init(10, 10)
gen(lab, 0, 0);
print_lab(lab);

