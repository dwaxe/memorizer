import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String
import List
import Regex exposing (..)


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { content : String
  }


model : Model
model =
  Model ""



-- UPDATE


type Msg
  = Change String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent }

firstLetters : String -> String
firstLetters =
  Regex.replace All (regex "\\B\\w") (\_ -> "_")
  -- firstLetters "Rock me now" == "R___ m_ n__"

firstWords : String -> String
firstWords words =
  words
    |> Regex.split All (regex "[\n\\!\\.\\?]+\\s*")
    |> List.map (Regex.replace All (regex "\\s(.*)") (\_ -> ""))
    |> String.join "\n"
  -- firstWords "Who am I? \n Why am I here?" == "Who\nWhy"

newLineHandler : String -> List (Html msg)
newLineHandler textBox =
  textBox
    |> String.split "\n"
    |> List.map Html.text
    |> List.intersperse ( br [] [] )

-- VIEW

place = """Text to \n
filter"""

view : Model -> Html Msg
view model =
  div []
    [ textarea [ placeholder "Fill this \n in", onInput Change ] []
    , div [] ( newLineHandler (firstLetters model.content) )
    , div [] ( newLineHandler (firstWords model.content) )
    ]
