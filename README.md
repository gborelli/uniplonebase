# uniplonebase


```python

        from z3c.form import form, field
        from collective.z3cform.colorpicker import Color
        from collective.z3cform.colorpicker import ColorAlpha

        class IColorForm(interface.Interface):
            color = Color(
                title=u"Color",
                description=u"",
                required=False,
                default="#ff0000"
            )
            alphacolor = ColorAlpha(
                title=u"Color with alpha layer support",
                description=u"",
                required=False,
                default=u"rgba(104,191,144,0.55)"
            )


        class ColorForm(form.Form):
            fields = field.Fields(IColorForm)
            ...

```
