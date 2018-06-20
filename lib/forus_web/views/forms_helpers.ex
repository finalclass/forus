defmodule ForusWeb.FormsHelpers do
  use Phoenix.HTML

  def forus_form_field(f, field, do: inner) do
    content_tag(
      :div,
      [
        label(f, field, class: 'label'),
        content_tag(
          :div,
          [
            inner
          ],
          class: 'control'
        ),
        ForusWeb.ErrorHelpers.error_tag(f, field)
      ],
      class: "field"
    )
  end

  def forus_text_field(f, field) do
    forus_form_field f, field do
      text_input(f, field, class: "input")
    end
  end

  def forus_password_field(f, field) do
    forus_form_field f, field do
      password_input(f, field, class: "input")
    end
  end
end
