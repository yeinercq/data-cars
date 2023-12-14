import { Controller } from "@hotwired/stimulus"
import Chart from 'chart.js/auto';
import { getRelativePosition } from 'chart.js/helpers';

// Connects to data-controller="line-chart"
export default class extends Controller {
  static targets = [ 'chart' ]
  static values = {
    // url: String,
    labels: Array,
    values: Array
  }

  connect() {

    console.log(this.valuesValue)
    console.log(this.labelsValue)

    const data = {
      labels: this.labelsValue,
      datasets: [{
        label: 'My First Dataset',
        data: this.valuesValue,
        fill: false,
        borderColor: 'rgb(75, 192, 192)',
        tension: 0.1
      }]
    };

    const chart = new Chart(this.chartTarget, {
      type: 'line',
      data: data,
      options: {
        onClick: (e) => {
          const canvasPosition = getRelativePosition(e, chart);
    
          // Substitute the appropriate scale IDs
          const dataX = chart.scales.x.getValueForPixel(canvasPosition.x);
          const dataY = chart.scales.y.getValueForPixel(canvasPosition.y);
        },
        elements: {
          line: {
            borderWidth: 3
          }
        }
      }
    });
  }
}
