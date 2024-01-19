using Bunit;
using EduTaskHub.Frontend.Components.Pages;

namespace EduTaskHub.Frontend.UnitTests
{
    public class CounterTests
    {
        [Fact]
        public void OnCounterClick_WhenClickCounterButton_ShouldIncrementByOne()
        {
            // Arrange 
            using var ctx = new TestContext();
            var cut = ctx.RenderComponent<Counter>();
            cut.Find("p").InnerHtml.MarkupMatches("Current count: 0");

            // Act
            cut.Find("button").Click();

            // Assert
            cut.Find("p").InnerHtml.MarkupMatches("Current count: 1");
        }
    }
}