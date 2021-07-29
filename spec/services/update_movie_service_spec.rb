require "rails_helper"

describe UpdateMovieService do
  let(:movie) { create :movie }
  let(:attributes) { {} }

  subject { described_class.call(movie.id, attributes) }

  it "marks movie as synced" do
    expect { subject }.to change { movie.reload.omdb_synced }.to(true)
  end

  it "returns success with movie" do
    expect(subject).to eq(Dry::Monads::Result::Success.new(movie))
  end

  context "title attr" do
    let(:title) { "new title"}
    let(:attributes) { { title: title } }

    it "updates title" do
      expect { subject }.to change { movie.reload.title }.to(title)
    end
  end

  context "description attr" do
    let(:description) { "new description"}
    let(:attributes) { { description: description } }

    it "updates description" do
      expect { subject }.to change { movie.reload.description }.to(description)
    end
  end

  context "runtime attr" do
    let(:runtime) { "100 minutes"}
    let(:attributes) { { runtime: runtime } }

    it "updates runtime" do
      expect { subject }.to change { movie.reload.runtime }.to(runtime)
    end
  end

  context "released_at attr" do
    let(:released_at) { Date.new }
    let(:attributes) { { released_at: released_at } }

    it "updates released_at" do
      expect { subject }.to change { movie.reload.released_at }.to(released_at)
    end
  end

  context "imdb_rating attr" do
    let(:imdb_rating) { BigDecimal("9.1") }
    let(:attributes) { { imdb_rating: imdb_rating } }

    it "updates imdb_rating" do
      expect { subject }.to change { movie.reload.imdb_rating }.to(imdb_rating)
    end
  end

  context "omdb_id attr" do
    let(:omdb_id) { "tt23" }
    let(:attributes) { { omdb_id: omdb_id } }

    it "doesn't update omdb_id" do
      expect { subject }.to_not change { movie.reload.omdb_id }
    end
  end
end
