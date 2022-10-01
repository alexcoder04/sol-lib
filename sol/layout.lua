
RootLayout = {
    elements = {}
}

function RootLayout:add(element)
    table.insert(self.elements, element)
end

function RootLayout:update()
    for i = 1, #(self.elements) do
        self.elements[i]:Update()
    end
end

function RootLayout:_draw(gc)
    for i = 1, #(self.elements) do
        self.elements[i]:_draw(gc)
    end
end
